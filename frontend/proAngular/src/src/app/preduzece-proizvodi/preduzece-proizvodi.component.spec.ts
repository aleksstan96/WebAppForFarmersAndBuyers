import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PreduzeceProizvodiComponent } from './preduzece-proizvodi.component';

describe('PreduzeceProizvodiComponent', () => {
  let component: PreduzeceProizvodiComponent;
  let fixture: ComponentFixture<PreduzeceProizvodiComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PreduzeceProizvodiComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PreduzeceProizvodiComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
