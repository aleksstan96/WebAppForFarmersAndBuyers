import { Component, OnInit, Inject } from '@angular/core';
import { ProizvodService } from 'src/app/servisi/proizvod.service';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { JeOcenio } from 'src/app/models/jeocenio';
import { UsersService } from 'src/app/servisi/users.service';
import { NgbRatingConfig } from '@ng-bootstrap/ng-bootstrap';
import { PoljoprivrednikService } from 'src/app/servisi/poljoprivrednik.service';
import { PorudzbiniService } from 'src/app/servisi/porudzbini.service';

@Component({
  selector: 'app-rejting',
  templateUrl: './rejting.component.html',
  styleUrls: ['./rejting.component.css']
})
export class RejtingComponent implements OnInit {

  idProizvoda: number;
  ocene: JeOcenio[] = [];
  rejtinzi: Rejting[]=[];
  mojaOcena: number=0;
  mojKomentar: string="";
  role:string ="";
  idUser: string = "";
  message: string = "";
  poljId: number;
   cnt:number = 0; //ovako odredjujem da li je korisnik narucivao proizvod
  constructor(@Inject(MAT_DIALOG_DATA) public data: any, //this is for data which is passed between dialog and host
              public dialogRef: MatDialogRef<RejtingComponent>,
              private service: ProizvodService,
              private userService: UsersService,
              private poljService: PoljoprivrednikService,
              private porService: PorudzbiniService,
              config: NgbRatingConfig) {
                config.max = 5;
                
               }

  ngOnInit(): void {
    
    
    this.idUser = sessionStorage.getItem('authenticatedUserId');
    this.idProizvoda = this.data.id;
    this.dohvatiOcene();
    this.role = sessionStorage.getItem('authenticatedUserRole');
    

    this.userService.findPoljoprivrednikByUserId(this.idUser).subscribe(
      data=>{
        if(data!=undefined){
          this.poljId = data.id;
          this.jeNarucivao();
        }
        
      }

    )
    console.log(this.role)
  }

  //dohvata recenzije proizvoda
  dohvatiOcene(){
    this.service.dohvatiOcene(this.idProizvoda).subscribe(
      data=>{
        this.ocene=data;
       
        //za svaku ocenu on dohvata username korisnika koji je dao tu ocenu
        for(let temp of this.ocene){
         
          this.userService.findUserById(temp.id.user_id).subscribe(
            data=>{
              let rejting: Rejting = new Rejting();
              rejting.ocena = temp.ocena;
              rejting.komentar = temp.komentar;
              rejting.username = data.username;
              this.rejtinzi.push(rejting);
            }
          )
        }

      }
    )
  }

  jeNarucivao(){

    this.poljService.getPorudzbineStatusIsporucena(this.poljId).subscribe(
      data=>{
        
        if(data.length>0){
          for(let d of data){
           // console.log(this.idProizvoda, d.id)
          this.porService.dohvatiProizvodPorudzbinaDvaParam(this.idProizvoda, d.id).subscribe(
            data=>{
             // console.log(data)
              if(data.length>0){
                //console.log("cnt++")
                this.cnt++;
              }
                ///////////////////////broji prihvacene
                this.poljService.getPorudzbineStatusPrihvacena(this.poljId).subscribe(
                  data=>{
                    
                    if(data.length>0){
                      for(let d of data){
                       // console.log(this.idProizvoda, d.id)
                      this.porService.dohvatiProizvodPorudzbinaDvaParam(this.idProizvoda, d.id).subscribe(
                        data=>{
                         // console.log(data)
                          if(data.length>0){
                            //console.log("cnt++")
                            this.cnt++;
                            
                          }
                        }
                      )
            
                    }
                    }
                    
            
                  }
                )
                
             
            }
          )

        }
        }
        

      }
    )

   
  }
  

  oceni(){
      if(this.mojaOcena==0){
        this.message="Unesite ocenu!"
      }else if(this.mojKomentar==""){
        this.message="Komentar je obavezan!";
      }else if(this.cnt==0){
        this.message="Niste naručivali ovaj proizvod!"
      }else{
        this.service.jeOcenio(this.idProizvoda,this.idUser).subscribe(
          data=>{
            if(data.length>0){
              this.message="Već ste ocenili ovaj proizvod!"
            }else{ //SVE JE OK I MOZE DA OCENI
              
              this.service.oceni(this.idProizvoda, this.idUser, this.mojKomentar,this.mojaOcena).subscribe(
                data=>{
                  this.ngOnInit()
                  //this.dialogRef.close();
                }
              )
    
            }
          }
        )
      }
      
    }
    
  }


class Rejting{
  ocena: number;
  komentar: string;
  username:string;
}
