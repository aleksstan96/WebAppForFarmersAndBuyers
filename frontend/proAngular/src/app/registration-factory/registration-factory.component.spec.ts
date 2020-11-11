import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RegistrationFactoryComponent } from './registration-factory.component';

describe('RegistrationFactoryComponent', () => {
  let component: RegistrationFactoryComponent;
  let fixture: ComponentFixture<RegistrationFactoryComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RegistrationFactoryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RegistrationFactoryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
