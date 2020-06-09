using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SportWebStore.Models;

namespace SportWebStore.Services
{
    public interface IItemService
    {
        List<Item> GetAll();
        List<Item> GetBestFiveRating();
        List<Item> GetSearchResult(string[] MainTag);
        Item GetOne(int itemID);
        void UpdateItemRating(int itemID, float itemRating);
    }
}
