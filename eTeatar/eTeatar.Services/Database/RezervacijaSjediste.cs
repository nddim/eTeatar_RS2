using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace eTeatar.Services.Database;

public class RezervacijaSjediste : ISoftDelete
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int RezervacijaSjedisteId { get; set; }

    public int RezervacijaId { get; set; }

    public int SjedisteId { get; set; }

    public virtual Rezervacija Rezervacija { get; set; } = null!;

    public virtual Sjediste Sjediste { get; set; } = null!;

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

}
