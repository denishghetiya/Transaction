using System;
using System.Collections.Generic;

namespace Transaction.DBContext;

public partial class Transaction
{
    public int TransactionId { get; set; }

    public int UserId { get; set; }

    public int CurrencyId { get; set; }

    public decimal Balance { get; set; }

    public decimal TransferAmount { get; set; }

    public string TransactionType { get; set; } = null!;

    public virtual CurrencyType Currency { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
