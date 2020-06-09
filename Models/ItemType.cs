using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportWebStore.Models
{
    public class ItemType
    {
        public string ItemTypeName { get; set; }
        public int ItemID { get; set; }

        public ItemType(string itemTypeName,int itemID)
        {
            ItemTypeName = itemTypeName;
            ItemID = itemID;
        }
    }
}
