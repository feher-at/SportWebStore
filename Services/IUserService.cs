using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SportWebStore.Models;

namespace SportWebStore.Services
{
    public interface IUserService
    {
        bool CheckIfUserExists(string email);
        bool Login(string email, string password);

        void Register(string userName, string password, string email, string role);
        User GetOne(string email);
    }
}
