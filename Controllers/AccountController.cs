using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using SportWebStore.Domain;
using SportWebStore.ViewModels;
using SportWebStore.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using SportWebStore.Models;

namespace SportWebStore.Controllers
{
    public class AccountController : Controller
    {
        private readonly IUserService _userService;
        private readonly IUserActivityService _UserActivityService;

        public AccountController(IUserService userService, IUserActivityService UserActivityService)
        {
            _userService = userService;
            _UserActivityService = UserActivityService;
        }

        [HttpGet]
        public IActionResult Registration()
        {
            return View();
        }
        public IActionResult LoginRegister()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Registration(RegistrationViewModel model)
        {
            if (!Utility.IsValidEmail(model.Email))
            {
                return RedirectToAction("Registration", "Account");
            }

            _userService.Register(model.Username, model.Password, model.Email, "user");

            User user = _userService.GetOne(model.Email);
            _UserActivityService.InsertActivity(user.UserId, "User registered on the site ", DateTime.Now);

            return RedirectToAction("Login");
        }

        

        [HttpGet]
        public async Task<ActionResult> LogOutAsync()
        {

            var user = HttpContext.User;
            var claim = user.Claims.First(c => c.Type == ClaimTypes.Email);
            var email = claim.Value;
            User currentUser = _userService.GetOne(email);
            _UserActivityService.InsertActivity(currentUser.UserId, "User logout", DateTime.Now);
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public async Task<ActionResult> LoginAsync(LoginViewModel model)
        {
            if (_userService.Login(model.Email,model.Password))
            {
                User user = _userService.GetOne(model.Email);
                var claims = new List<Claim> { new Claim(ClaimTypes.Email, model.Email),
                                               new Claim(ClaimTypes.Role, user.Role)};

                var claimsIdentity = new ClaimsIdentity(
                    claims, CookieAuthenticationDefaults.AuthenticationScheme);

                var authProperties = new AuthenticationProperties
                {
                    //AllowRefresh = <bool>,
                    // Refreshing the authentication session should be allowed.

                    //ExpiresUtc = DateTimeOffset.UtcNow.AddMinutes(10),
                    // The time at which the authentication ticket expires. A 
                    // value set here overrides the ExpireTimeSpan option of 
                    // CookieAuthenticationOptions set with AddCookie.

                    //IsPersistent = true,
                    // Whether the authentication session is persisted across 
                    // multiple requests. When used with cookies, controls
                    // whether the cookie's lifetime is absolute (matching the
                    // lifetime of the authentication ticket) or session-based.

                    //IssuedUtc = <DateTimeOffset>,
                    // The time at which the authentication ticket was issued.

                    //RedirectUri = <string>
                    // The full path or absolute URI to be used as an http 
                    // redirect response value.
                };

                await HttpContext.SignInAsync(
                    CookieAuthenticationDefaults.AuthenticationScheme,
                    new ClaimsPrincipal(claimsIdentity),
                    authProperties);
               
                _UserActivityService.InsertActivity(user.UserId, "User login on the site ", DateTime.Now);

                return RedirectToAction("Index", "Home");
            }
            
            else
            {
                ModelState.AddModelError(string.Empty, "Incorrect E-mail and/or Password. Please try again.");
                return View("Login");
            }
            
        }
        [HttpGet]
        public IActionResult Settings()
        {
            var user = HttpContext.User;
            var claim = user.Claims.First(c => c.Type == ClaimTypes.Email);
            var email = claim.Value;
            User searchedUser = _userService.GetOne(email);

            return View(searchedUser);
        }
    }
}