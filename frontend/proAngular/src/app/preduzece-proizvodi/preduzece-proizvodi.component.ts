import { Component, OnInit, ViewChild } from '@angular/core';
import { PreduzeceService } from '../servisi/preduzece.service';
import { Proizvod } from '../models/proizvod';
import { MatSort } from '@angular/material/sort';
import { ActivatedRoute } from '@angular/router';
import { MatTableDataSource } from '@angular/material/table';
import { MatDialog, MatDialogConfig } from '@angular/material/dialog';
import { DodavanjeProizvodaComponent } from '../dialog/dodavanje-proizvoda/dodavanje-proizvoda.component';
import { ProizvodService } from '../servisi/proizvod.service';

@Component({
  selector: 'app-preduzece-proizvodi',
  templateUrl: './preduzece-proizvodi.component.html',
  styleUrls: ['./preduzece-proizvodi.component.css']
})
export class PreduzeceProizvodiComponent implements OnInit {

  proizvodi: Proizvod[] = [];
  role: string = "preduzece"
  preduzeceId: number //= 1; //FIKSNO, PREPRAVI

  constructor(private route: ActivatedRoute,private proizvodService: ProizvodService, private service: PreduzeceService, private dialog: MatDialog) { }

  ngOnInit(): void {
    this.route.paramMap.subscribe(()=>{
      this.dohvatiProizvode();
      
    });
    const userId = sessionStorage.getItem("authenticatedUserId");
    this.service.findByUserdId(userId).subscribe(
      data=>{
        this.preduzeceId=data.id
      }
    )
  }

  otvoriDialogDodavanjeProizvoda(){
    
    const dialogConfig = new MatDialogConfig();
     dialogConfig.data = { preduzeceId: `${this.preduzeceId}`} //na ovaj nacin prosledjujemo dijalogu id preduzeca
     let matDialog = this.dialog.open(DodavanjeProizvodaComponent, dialogConfig);
     
     matDialog.afterClosed().subscribe(
       data =>{
         this.ngOnInit();
 
       }
       
     );

  }

  dohvatiProizvode(){
    const preduzeceId: number= +this.route.snapshot.paramMap.get('id');

    this.service.dohvatiProizvodePreduzeca(preduzeceId).subscribe(
      data=>{
        this.proizvodi = data;
        this.dataSource = new MatTableDataSource(data);
        this.dataSource.sort = this.sort;
      }
    )
    
  }



  obrisi(idProizvoda){
    this.proizvodService.obrisiProizvod(idProizvoda).subscribe(
      data=>{
        this.ngOnInit()
      }
    )
  }









   /////////////////angular matrial tabela
   displayedColumns: string[] = ['naziv', 'cena', 'kolicina', 'id'];
   dataSource;
   @ViewChild(MatSort, {static: true}) sort: MatSort;
 
   applyFilter(event: Event) {
     const filterValue = (event.target as HTMLInputElement).value;
     this.dataSource.filter = filterValue.trim().toLowerCase();
   }

}
