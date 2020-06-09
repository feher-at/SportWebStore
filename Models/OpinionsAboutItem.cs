using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportWebStore.Models
{
    public class OpinionsAboutItem
    {
        public int OpinionID { get; set; }
        public string UserName { get; set; }
        public string Opinion { get; set; }
        public int TheUserRating { get; set; }
        public DateTime PostDate { get; set; }
        public int ItemID { get; set; }
       
        public OpinionsAboutItem(int opinionID,string userName,string opinion,int theUserRating,DateTime postDate,int itemID)
        {
            OpinionID = opinionID;
            UserName = userName;
            Opinion = opinion;
            TheUserRating = theUserRating;
            PostDate = postDate;
            ItemID = itemID;
        }
    }
}
