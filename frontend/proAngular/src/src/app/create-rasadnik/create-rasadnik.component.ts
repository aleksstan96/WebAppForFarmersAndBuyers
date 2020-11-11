import { Component, OnInit, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { Rasadnik } from '../models/rasadnik';
import { RasadnikService } from '../servisi/rasadnik.service';
import { PoljoprivrednikService } from '../servisi/poljoprivrednik.service';

@Component({
  selector: 'app-create-rasadnik',
  templateUrl: './create-rasadnik.component.html',
  styleUrls: ['./create-rasadnik.component.css']
})
export class CreateRasadnikComponent implements OnInit {

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, //this is for data which is passed between dialog and host
  public dialogRef: MatDialogRef<CreateRasadnikComponent>,
  private service: RasadnikService,
  private poljService: PoljoprivrednikService) { }

  poljoprivrednikId : number;
  rasadnikId : number;
  ngOnInit(): void {  
    this.noviRasadnik= new Rasadnik();
    this.poljoprivrednikId = this.data.poljoprivrednikId; //ovde kupimo id poljoprivrednika koji smo prosledili dijalogu
   
  }

  noviRasadnik : Rasadnik ;


  save(name, place, height, width){
    if(name=="" || place=="" || height==null || width==null || name==undefined || place==undefined || height==undefined || width==undefined){
      alert("Unesite sve podatke!")
    }else if(height<1 || width<1){
      alert("Širina i visina moraju imati vrednosti veće od 0!")
    }
     else{
        this.noviRasadnik.naziv = name;
        this.noviRasadnik.mesto = place;
        this.noviRasadnik.sirina = width;
        this.noviRasadnik.duzina = height;
        this.noviRasadnik.brSlobodnih = height*width;
        this.noviRasadnik.brSadnica = 0;
        this.noviRasadnik.temperatura = 18;
        this.noviRasadnik.voda = 200;
        this.service.saveRasadnik(this.noviRasadnik).subscribe(
          data =>{
            this.rasadnikId = data.id
          this.service.dodeliPoljoprivrednika(this.rasadnikId, this.poljoprivrednikId).subscribe(
            data=>{
              this.dialogRef.close(this.rasadnikId);
            }
          ); //odmah nakon kreiranja dodelimo rasadniku poljoprivrednika 
      
          }   ) ;
        

        
    }
    

  }

}
