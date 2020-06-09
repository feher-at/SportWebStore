using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SportWebStore.Models;
using System.Data;
using SportWebStore.Domain;

namespace SportWebStore.Services
{
    public class UserService: BaseService,IUserService
    {
        private static User ToUser(IDataReader reader)
        {
            return new User
            (
               (int)reader["userid"],
               (string)reader["username"],
               (string)reader["user_password"],
               (string)reader["email"],
               (string)reader["user_role"]

            );
        }

        private readonly IDbConnection _connection;

        public UserService(IDbConnection connection)
        {
            _connection = connection;
        }

        public bool CheckIfUserExists(string email)
        {
            using var command = _connection.CreateCommand();
            command.CommandText = $"SELECT true FROM users WHERE email = '{email}'";
            var param = command.CreateParameter();
            param.ParameterName = "email";
            param.Value = email;
            bool UserExist = Convert.ToBoolean(command.ExecuteScalar());

            return UserExist;
        }

        public bool Login(string email, string password)
        {
            using var command = _connection.CreateCommand();

            var userEmailParam = command.CreateParameter();
            userEmailParam.ParameterName = "email";
            userEmailParam.Value = email;

            var passwordParam = command.CreateParameter();
            passwordParam.ParameterName = "password";
            passwordParam.Value = Utility.Hash(password);
            command.CommandText = $"SELECT * FROM users WHERE email = @email AND user_password = @password";
            command.Parameters.Add(userEmailParam);
            command.Parameters.Add(passwordParam);

            using var reader = command.ExecuteReader();
            if (reader.Read())
            {
                return true;
            }
            return false;
        }

        public void Register(string userName, string password, string email, string role)
        {
            using var command = _connection.CreateCommand();

            var userNameParam = command.CreateParameter();
            userNameParam.ParameterName = "username";
            userNameParam.Value = userName;
            var passwordParam = command.CreateParameter();
            passwordParam.ParameterName = "password";
            passwordParam.Value = Utility.Hash(password);
            var emailParam = command.CreateParameter();
            emailParam.ParameterName = "email";
            emailParam.Value = email;
            var roleParam = command.CreateParameter();
            roleParam.ParameterName = "role";
            roleParam.Value = role;

            command.CommandText = $"INSERT INTO users(username,user_password,email,user_role) VALUES (@username, @password, @email, @role)";
            command.Parameters.Add(userNameParam);
            command.Parameters.Add(passwordParam);
            command.Parameters.Add(emailParam);
            command.Parameters.Add(roleParam);

            HandleExecuteNonQuery(command);

        }

        public User GetOne(string email)
        {
            using var command = _connection.CreateCommand();
            var userNameParam = command.CreateParameter();
            userNameParam.ParameterName = "email";
            userNameParam.Value = email;
            command.Parameters.Add(userNameParam);

            command.CommandText = "SELECT * FROM users WHERE email = @email";

            using var reader = command.ExecuteReader();

            reader.Read();
            return ToUser(reader);
        }
    }
}
