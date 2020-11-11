export class PredZahtev{
    id:number;
    naziv:string;
    skracenica:string;
    password:string;
    datumOsnivanja: Date;
    mestoOsnivanja: Date;
    email:string;
    prihvacen:boolean;
    nijePrihvacen:boolean;
}

export class PoljZahtev{
    id:number;
    ime:string;
    prezime:string;
    username:string;
    password:string;
    datumRodjenja: Date;
    mestoRodjenja: Date;
    telefon:number;
    email:string;
    prihvacen:boolean;
    nijePrihvacen:boolean;
}