using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;

namespace Transaction.ViewModel
{
    public class WalletViewModel
    {
        [Required]
        public int CurrencyId { get; set; }

        [Required]
        [Range(0, double.MaxValue)]
        public decimal Balance { get; set; }

        public List<SelectListItem> CurrencyList { get; set; } = new List<SelectListItem>();

        public int WalletId { get; set; }
        public int UserId { get; set; }
        public int SelectedCurrencyId { get; set; } 

    }
}
