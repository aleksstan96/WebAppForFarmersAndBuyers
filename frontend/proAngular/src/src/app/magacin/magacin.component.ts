import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { MagacinService } from '../servisi/magacin.service';
import { MagacinProizvod } from '../models/magacinproizvod';
import {MatTableDataSource} from '@angular/material/table';
import {MatSort} from '@angular/material/sort';
import { PoljoprivrednikService } from '../servisi/poljoprivrednik.service';
import { RasadnikService } from '../servisi/rasadnik.service';

@Component({
  selector: 'app-magacin',
  templateUrl: './magacin.component.html',
  styleUrls: ['./magacin.component.css']
})
export class MagacinComponent implements OnInit {
  
  proizvodiSadnice: MagacinProizvod[] = []; //sadnice u magacinu
  proizvodiPreparati: MagacinProizvod[] = []; //preparati u magacinu
  proizvodi: MagacinProizvod[] = [];
  kategorija: string = 'sve';
  magacinId: number=0;
  rasadnikId: number=0;
 

  constructor( private route: ActivatedRoute,
               private service: MagacinService,
               private rasadnikService: RasadnikService) { }

  ngOnInit(): void {
    //console.log(sessionStorage.getItem("authenticatedUserId"))
    
    this.route.paramMap.subscribe(()=>{
     this.dohvatiMagacin();
      // this.prikazi();

    });
  }

  dohvatiMagacin(){
    this.rasadnikId= +this.route.snapshot.paramMap.get('id');

    this.rasadnikService.dohvatiMagacin(this.rasadnikId).subscribe(
      data=>{
        this.magacinId=data.id;
        this.dohvatiProizvode();
        this.dohvatiSadnice();
        this.dohvatiPreparate();
      }
    )
  }


  //dohvatamo proizvode kategorije "sadnica"
  dohvatiSadnice(){
  //  this.magacinId= +this.route.snapshot.paramMap.get('id');
    this.service.dohvatiSadnice(this.magacinId).subscribe(
      data=>{
        this.proizvodiSadnice = data;
       
      }
    );

  }

  //dohvatamo proizvode kategorije "preparat"
  dohvatiPreparate(){
  //  const magacinId: number= +this.route.snapshot.paramMap.get('id');
    this.service.dohvatiPreparate(this.magacinId).subscribe(
      data=>{
        this.proizvodiPreparati = data;
        
      }
    );
  }

  //dohvatamo proizvode kategorije "preparat"
  dohvatiProizvode(){
  //  const magacinId: number= +this.route.snapshot.paramMap.get('id');
    this.service.dohvatiProizvode(this.magacinId).subscribe(
      data=>{
        this.proizvodi= data;

        this.dataSource = new MatTableDataSource(data);
        // setTimeout(() => {
        //   this.dataSource.sort = this.sort;
        // });
        this.dataSource.sort = this.sort;
      }
    );
  }


  /////////////////angular matrial tabela
  displayedColumns: string[] = ['naziv', 'proizvodjac', 'kolicina'];
  dataSource;
  @ViewChild(MatSort, {static: true}) sort: MatSort;

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }

}


export class ProizvodElement {
  naziv: string;
  proizvodjac: string;
  kolicina: number;
}

const ELEMENT_DATA: ProizvodElement[] = [
  {naziv: "a", kolicina: 2, proizvodjac: "a"}
];