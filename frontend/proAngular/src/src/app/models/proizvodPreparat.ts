import { Proizvod } from './proizvod';

export class ProizvodPreparat implements Proizvod{
    //nasledjeno
    naziv: string;
    prizvodjac: string;
    cena: number;
    kolicina: number;
    kategorija: string; //mozda bude i number ako je id
    slikaUrl: string;
    ///
    ubrzavaZa: number;
}