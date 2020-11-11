import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { DodavanjeAdminaComponent } from './dodavanje-admina.component';

describe('DodavanjeAdminaComponent', () => {
  let component: DodavanjeAdminaComponent;
  let fixture: ComponentFixture<DodavanjeAdminaComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ DodavanjeAdminaComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DodavanjeAdminaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
