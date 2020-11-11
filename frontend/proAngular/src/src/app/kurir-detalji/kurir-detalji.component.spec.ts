import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { KurirDetaljiComponent } from './kurir-detalji.component';

describe('KurirDetaljiComponent', () => {
  let component: KurirDetaljiComponent;
  let fixture: ComponentFixture<KurirDetaljiComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ KurirDetaljiComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(KurirDetaljiComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
