using System;
using System.Collections.Generic;

namespace Transaction.DBContext;

public partial class CurrencyType
{
    public int CurrencyId { get; set; }

    public string CurrencyCode { get; set; } = null!;

    public virtual ICollection<Transaction> Transactions { get; set; } = new List<Transaction>();

    public virtual ICollection<Wallet> Wallets { get; set; } = new List<Wallet>();
}
