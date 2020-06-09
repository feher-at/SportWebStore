using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SportWebStore.Models;

namespace SportWebStore.Services
{
    public interface IUserActivityService
    {
        List<UserActivity> GetAllActivity();
        void InsertActivity(int userID, string activity, DateTime activityTime);

    }
}
