using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SportWebStore.Models;

namespace SportWebStore.Services
{
    public interface IOpinionService
    {
        List<OpinionsAboutItem> GetAllOpinionsToAnItem(int itemID);
        void InsertOpinion(int userID, string opinion, int userRating, DateTime postTime, int itemID);
    }
}
