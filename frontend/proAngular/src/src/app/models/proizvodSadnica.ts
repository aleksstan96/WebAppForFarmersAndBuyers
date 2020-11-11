import { Proizvod } from './proizvod';

export class ProizvodSadnica implements Proizvod{
    //nasledjeno
    naziv: string;
    prizvodjac: string;
    cena: number;
    kolicina: number;
    kategorija: string;
    slikaUrl: string;
    ///
    zivotniVek: number; //mozda progres racunati kao zivotniVek:prosloDana = 1 : progres => progres = prosloDana/zivotniVek


}