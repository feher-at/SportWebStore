using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportWebStore.Models
{
    public class ItemMainType
    {
        public int MainTagID { get; set; }
        public string MainTagName { get; set; }

        public ItemMainType(int mainTagID,string mainTagName)
        {
            MainTagID = mainTagID;
            MainTagName = mainTagName;
        }
    }
}
