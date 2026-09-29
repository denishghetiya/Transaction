using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Transaction.DBContext;
using System.Linq;
using System.Security.Claims;
using Transaction.ViewModel;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Transaction.Controllers
{
    [Authorize]
    public class WalletController : Controller
    {
        private readonly ApplicationDBContext _context;

        public WalletController(ApplicationDBContext context)
        {
            _context = context;
        }


        [HttpPost]
        public IActionResult CreateWallet(WalletViewModel model)
        {
            int userId = int.Parse(User.FindFirstValue("UserID"));

            var existingWallet = _context.Wallets
                .FirstOrDefault(w => w.UserId == userId && w.CurrencyId == model.CurrencyId);

            if (existingWallet != null)
            {
                return RedirectToAction("Dashboard", "User");
            }

            var wallet = new Wallet
            {
                UserId = userId,
                CurrencyId = model.CurrencyId,
                Balance = model.Balance
            };
            var transaction = new Transaction.DBContext.Transaction
            {
                UserId = wallet.UserId,
                CurrencyId = wallet.CurrencyId,
                Balance = wallet.Balance,
                TransferAmount = wallet.Balance,
                TransactionType = "Credit"
            };

            _context.Wallets.Add(wallet);
            _context.Transactions.Add(transaction);
            _context.SaveChanges();

            return RedirectToAction("Dashboard", "User");
        }

        [HttpPost]
        public IActionResult AddBalance(int WalletId, decimal Amount)
        {
            int userId = int.Parse(User.FindFirstValue("UserID"));

            var wallet = _context.Wallets.FirstOrDefault(w => w.UserId == userId && w.WalletId == WalletId);
            if (wallet == null)
            {
                return RedirectToAction("Dashboard", "User");
            }

            wallet.Balance += Amount;

            var transaction = new Transaction.DBContext.Transaction
            {
                UserId = wallet.UserId,
                CurrencyId = wallet.CurrencyId,
                Balance = wallet.Balance,
                TransferAmount = Amount,
                TransactionType = "Credit"
            };

            _context.Transactions.Add(transaction);
            _context.SaveChanges();

            return RedirectToAction("Dashboard", "User");
        }


        [HttpPost]
        public IActionResult WithdrawBalance(int WalletId, decimal Amount)
        {
            int userId = int.Parse(User.FindFirstValue("UserID"));

            var wallet = _context.Wallets.FirstOrDefault(w => w.UserId == userId && w.WalletId == WalletId);

            if (wallet.Balance < Amount)
            {
                TempData["Error"] = "Insufficient balance!";
                return RedirectToAction("Dashboard", "User");
            }

            wallet.Balance -= Amount;

            var transaction = new Transaction.DBContext.Transaction
            {
                UserId = wallet.UserId,
                CurrencyId = wallet.CurrencyId,
                Balance = wallet.Balance,
                TransferAmount = Amount,
                TransactionType = "Debit"
            };

            _context.Transactions.Add(transaction);
            _context.SaveChanges();

            return RedirectToAction("Dashboard", "User");
        }


        [HttpPost]
        public IActionResult SendMoney(int SenderWalletId, string ReceiverWalletCode, decimal TransferAmount)
        {
            int userId = int.Parse(User.FindFirstValue("UserID"));

            var receiverWallet = _context.Wallets.FirstOrDefault(w => w.WalletCode.ToString() == ReceiverWalletCode);
            if (receiverWallet == null)
            {
                TempData["Error"] = "Receiver wallet not found!";
                return RedirectToAction("Dashboard", "User");
            }

            var senderWallet = _context.Wallets.FirstOrDefault(w => w.UserId == userId && w.CurrencyId == receiverWallet.CurrencyId && w.WalletId == SenderWalletId);
            if (senderWallet == null)
            {
                TempData["Error"] = "No wallet found! Please create a wallet first.";
                return RedirectToAction("Dashboard", "User");
            }

            if (senderWallet.Balance < TransferAmount)
            {
                TempData["Error"] = "Insufficient balance!";
                return RedirectToAction("Dashboard", "User");
            }

            senderWallet.Balance -= TransferAmount;

            receiverWallet.Balance += TransferAmount;

            List<DBContext.Transaction> transactions = new List<DBContext.Transaction>();

            transactions.Add(new Transaction.DBContext.Transaction
            {
                UserId = senderWallet.UserId,
                CurrencyId = senderWallet.CurrencyId,
                Balance = senderWallet.Balance,
                TransferAmount = TransferAmount,
                TransactionType = "Debit"
            });

            transactions.Add(new Transaction.DBContext.Transaction
            {
                UserId = receiverWallet.UserId,
                CurrencyId = receiverWallet.CurrencyId,
                Balance = receiverWallet.Balance,
                TransferAmount = TransferAmount,
                TransactionType = "Credit"
            });

            _context.Transactions.AddRange(transactions);
            _context.SaveChanges();

            return RedirectToAction("Dashboard", "User");
        }



    }
}
