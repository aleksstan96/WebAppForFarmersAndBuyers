import { Component, OnInit, Inject } from '@angular/core';
import { Proizvod } from 'src/app/models/proizvod';
import { ProizvodService } from 'src/app/servisi/proizvod.service';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import {STEPPER_GLOBAL_OPTIONS} from '@angular/cdk/stepper';
import { FormGroup, Validators, FormBuilder, FormControl } from '@angular/forms';

@Component({
  selector: 'app-dodavanje-proizvoda',
  templateUrl: './dodavanje-proizvoda.component.html',
  styleUrls: ['./dodavanje-proizvoda.component.css'],
  providers: [{
    provide: STEPPER_GLOBAL_OPTIONS, useValue: {showError: true}
  }]
})
export class DodavanjeProizvodaComponent implements OnInit {

  ///////stepper
  firstFormGroup: FormGroup;
  secondFormGroup: FormGroup;
  thirdFormGroup: FormGroup;
  forthFormGroup: FormGroup;
  fifthFormGroup: FormGroup;
  sixthFormGroup: FormGroup;
  seventhFormGroup: FormGroup;
  eighthFormGroup: FormGroup;
/////
  preduzeceId: number;
  proizvod: Proizvod = new Proizvod();
  message:string="";

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, //this is for data which is passed between dialog and host
  public dialogRef: MatDialogRef<DodavanjeProizvodaComponent>,
  private service: ProizvodService,private _formBuilder: FormBuilder) { }

  ngOnInit(): void {
    this.preduzeceId = this.data.preduzeceId;
    console.log(this.preduzeceId);
    ///stepper
    this.firstFormGroup = this._formBuilder.group({
      firstCtrl: ['', Validators.required]
    });
    this.secondFormGroup = this._formBuilder.group({
      secondCtrl: ['', Validators.required]
    });
    this.thirdFormGroup = this._formBuilder.group({
      secondCtrl: ['', Validators.required]
    });
    this.forthFormGroup = this._formBuilder.group({
      secondCtrl: ['', Validators.required]
    });
    this.fifthFormGroup = this._formBuilder.group({
      secondCtrl: ['', Validators.required]
    });
    this.sixthFormGroup = this._formBuilder.group({
      secondCtrl: ['', Validators.required]
    });
    this.seventhFormGroup = this._formBuilder.group({
      secondCtrl: ['', Validators.required]
    });
    this.eighthFormGroup = this._formBuilder.group({
      secondCtrl: ['', Validators.required]
    });

  }
  click(){
    console.log(this.proizvod.naziv)
  }

  save(){
    this.message="";
    this.proizvod.slikaUrl="assets\\images\\logo.png";
    if(this.proizvod.kategorija!="sadnica" && this.proizvod.kategorija!="preparat"){
      this.message='Proizvod mora imati kategoriju "sadnica" ili "preparat!" ';
    }else if(this.proizvod.cena<1){
      this.message='Cena mora biti veca od 0'
    }else if(this.proizvod.kolicina<1){
      this.message="kolicina mora biti veca od 0"
    }else if(this.proizvod.dani<1){
      if(this.proizvod.kategorija=='sadnica'){
        this.message="Zivotni vek sadnice mora biti veci od 0"
      }else{
        this.message="Broj dana za koji preparat ubrzava rast mora biti veci od 0"
      }
    }
    else{
     console.log(this.proizvod)
      this.proizvod.ocena = 0;
        this.service.dodajProizvod(this.proizvod).subscribe(
          data=>{
            let id = data.id;
            this.service.dodeliPreduzeceProizvodu(id, this.preduzeceId).subscribe(
              data=>{
                this.dialogRef.close(this.proizvod);
              }
            )
          }
        )
    }
   

  }

}
