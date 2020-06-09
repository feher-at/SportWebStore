using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportWebStore.Models
{
    public class Item
    {
        public int ItemID { get; private set; }
        public string ItemSource { get; private set; }
        public int ItemPriece { get; private set; }
        public string ItemDescription { get; private set; }
        public string ItemType { get; private set; }
        public string ItemColour { get; private set; }
        public float Rating { get; set; }
       



        public Item(int itemID, string itemSource, int itemPrice, string itemDescription,string itemType, string itemColour, float rating)
        {

            ItemID = itemID;
            ItemSource = itemSource;
            ItemPriece = itemPrice;
            ItemDescription = itemDescription;
            ItemType = itemType;
            ItemColour = itemColour;
            Rating = rating;
        }


    }
}
