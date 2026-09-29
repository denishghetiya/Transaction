using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Authorization;
using Transaction.DBContext;
using Transaction.ViewModel;
using System.Security.Claims;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Transaction.Controllers
{
    public class UserController : Controller
    {
        private readonly ApplicationDBContext _context;
        public UserController(ApplicationDBContext context)
        {
            _context = context;
        }

        public IActionResult Dashboard()
        {
            ViewBag.Username = User.Identity.Name;
            int userId = int.Parse(User.FindFirstValue("UserID"));

            var userWallets = _context.Wallets
                .Where(w => w.UserId == userId)
                .Select(w => w.CurrencyId)
                .ToList();

            ViewBag.AvailableCurrencies = _context.CurrencyTypes
                .Where(c => !userWallets.Contains(c.CurrencyId))
                .ToList();

            var wallet = _context.Wallets.Include(w => w.Currency)
                .FirstOrDefault(w => w.UserId == userId);

            if (wallet == null)
            {
                ViewBag.CurrencyCode = "No Wallet";
                ViewBag.WalletBalance = 0;
                ViewBag.Transactions = new List<Transaction.DBContext.Transaction>();
            }
            else
            {
                ViewBag.UserWallet = _context.Wallets
                    .Where(w => w.UserId == userId)
                    .Include(t => t.Currency)
                    .ToList(); ;
                ViewBag.Transactions = _context.Transactions
                    .Where(t => t.UserId == userId)
                    .Include(t => t.Currency)
                    .ToList();
                var wallets = _context.Wallets.Include(w => w.Currency).Include(w => w.User).ToList();
                ViewBag.AllWallets = wallets;
            }

            return View();
        }



        
    }
}
