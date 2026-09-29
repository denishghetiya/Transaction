using System;
using System.Collections.Generic;

namespace Transaction.DBContext;

public partial class Wallet
{
    public int WalletId { get; set; }

    public Guid WalletCode { get; set; }

    public int UserId { get; set; }

    public int CurrencyId { get; set; }

    public decimal Balance { get; set; }

    public virtual CurrencyType Currency { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
