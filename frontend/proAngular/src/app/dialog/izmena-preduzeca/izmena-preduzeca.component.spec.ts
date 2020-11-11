import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { IzmenaPreduzecaComponent } from './izmena-preduzeca.component';

describe('IzmenaPreduzecaComponent', () => {
  let component: IzmenaPreduzecaComponent;
  let fixture: ComponentFixture<IzmenaPreduzecaComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ IzmenaPreduzecaComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IzmenaPreduzecaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
