import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { DodavanjePreduzecaComponent } from './dodavanje-preduzeca.component';

describe('DodavanjePreduzecaComponent', () => {
  let component: DodavanjePreduzecaComponent;
  let fixture: ComponentFixture<DodavanjePreduzecaComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ DodavanjePreduzecaComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DodavanjePreduzecaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
