using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportWebStore.Models
{
    public class User
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Role { get; set; }


        public User(int userId, string username, string password, string email,string role)
        {
            UserId = userId;
            UserName = username;
            Email = email;
            Password = password;
            Role = role;
            
        }
    }
}
