using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SportWebStore.Models;
using SportWebStore.Services;
using Microsoft.AspNetCore.Http.Extensions;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

namespace SportWebStore.Controllers
{
    public class HomeController : Controller
    {
       
        private readonly IItemService _ItemService;
        private readonly IBrandService _BrandService;
        private readonly IItemTypeService _ItemTypeService;
        private readonly IItemMainTypeService _ItemMainTypeService;
        private readonly IOpinionService _OpinionService;
        private readonly IUserService _UserService;
        private readonly IUserActivityService _UserActivityService;

        public HomeController(IItemService itemService, IBrandService brandService, IItemTypeService itemTypeService, IItemMainTypeService itemMainTypeService, IOpinionService opinionService, IUserService userService, IUserActivityService userActivityService )
        {
            _ItemService = itemService;
            _BrandService = brandService;
            _ItemTypeService = itemTypeService;
            _ItemMainTypeService = itemMainTypeService;
            _OpinionService = opinionService;
            _UserService = userService;
            _UserActivityService = userActivityService;
        }
        
        [HttpGet]
        public IActionResult Index()
        {
            return View(_ItemService.GetBestFiveRating());
        }
       

        public IActionResult Privacy()
        {
            return View();
        }

        [HttpGet]
        public IActionResult Store()
        {
            List<Item> listOfItem = _ItemService.GetAll();
            List<Brand> listOfBrand = _BrandService.GetAllBrands();
            List<ItemType> listOfItemType = _ItemTypeService.GetAllItemType();
            List<ItemMainType> listOfItemMainType = _ItemMainTypeService.GetAllMainType();
            ItemsWithBrandAndType itemsWithBrandAndType = new ItemsWithBrandAndType(listOfItem, listOfBrand, listOfItemType,listOfItemMainType);
            
            return View(itemsWithBrandAndType);
        }
        [HttpGet]
        [Authorize]
        public IActionResult Details()
        {
            string _getUri = Request.GetDisplayUrl();
            string[] strArray = _getUri.Split('/');
            int iD = Convert.ToInt32(strArray[5]);
            return View(_ItemService.GetOne(iD));
        }

        [HttpPost]
        [ActionName("Store")]
        public void Details([FromForm(Name = "ItemID")] int ID)
        {

            Response.Redirect($"Details/{ID}");
        }

        [HttpPost]
        [ActionName("Index")]
        public void Detail([FromForm(Name = "ItemID")] int ID)
        {

            Response.Redirect($"Home/Details/{ID}");
        }

        

        [HttpPost]
        
        public IActionResult Sorting()
        {
            string[] mainType = Request.Form["chosenType"];
            List<Item> listOfItem = _ItemService.GetSearchResult(mainType);
          
            return Json(listOfItem);
        }


        [HttpPost]
        public IActionResult ItemDetail()
        {
            int ItemID = Convert.ToInt32(Request.Form["chosenType"]);

            Item item = _ItemService.GetOne(ItemID);
            Brand brand = _BrandService.GetBrandToAnItem(ItemID);
            ItemWithBrand itemWithBrand = new ItemWithBrand(item, brand);

            return Json(itemWithBrand);
        }

        [HttpPost]
        
        public IActionResult Opinions()
        {
            int ItemID = Convert.ToInt32(Request.Form["chosenType"]);
            List<OpinionsAboutItem> opinions = _OpinionService.GetAllOpinionsToAnItem(ItemID);
            return Json(opinions);
        }

        [HttpPost]
        [ActionName("Details")]
        public void Post([FromForm(Name = "rating")] int rate, [FromForm(Name = "Textarea")] string review, [FromForm(Name = "DetailsID")] int itemID)
        {
            var user = HttpContext.User;
            var claim = user.Claims.First(c => c.Type == ClaimTypes.Email);
            var email = claim.Value;
            User searchedUser = _UserService.GetOne(email);
            _OpinionService.InsertOpinion(searchedUser.UserId, review, rate, DateTime.Now, itemID);

            List<OpinionsAboutItem> reviews = _OpinionService.GetAllOpinionsToAnItem(itemID);
            float itemRating = 0;
            foreach (OpinionsAboutItem Onereview in reviews)
            {
                itemRating += Onereview.TheUserRating;
            }
            itemRating /= reviews.Count();
            _ItemService.UpdateItemRating(itemID, itemRating);
            string activity = "The user post a review";
            _UserActivityService.InsertActivity(searchedUser.UserId, activity, DateTime.Now);

            Response.Redirect($"https://localhost:5001/Home/Details/{itemID}");
        }

        [HttpGet]
        public IActionResult GetActivities()
        {
            List<UserActivity> activities = _UserActivityService.GetAllActivity();
            return Json(activities);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
