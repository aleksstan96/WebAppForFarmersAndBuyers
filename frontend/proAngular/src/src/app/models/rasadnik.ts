import { Poljoprivrednik } from './poljoprivrednik';

export class Rasadnik{
    
    id :number;
    naziv: string;
    mesto: string;
    brSadnica: number;
    brSlobodnih: number;
    kapacitet: number;
    voda: number;
    temperatura: number;
    duzina: number;
    sirina: number;
    poljoprivrednik: Poljoprivrednik;

}