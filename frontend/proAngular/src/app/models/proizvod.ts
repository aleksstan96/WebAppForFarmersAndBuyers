export class Proizvod{
    id: number;
    slikaUrl: string;
     naziv: string;
    dani: number;
    cena: number;
    kolicina: number;
    kategorija: string;
    info: string;
    proizvodjac: string;
    ocena: number;

}

export class ProizvodKorpa{
    id: number;
    slikaUrl: string;
    naziv: string;
    proizvodjac: string;
    cena: number;
    kolicina: number;
}