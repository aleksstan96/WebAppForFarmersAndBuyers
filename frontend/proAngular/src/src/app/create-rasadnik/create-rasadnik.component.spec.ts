import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { CreateRasadnikComponent } from './create-rasadnik.component';

describe('CreateRasadnikComponent', () => {
  let component: CreateRasadnikComponent;
  let fixture: ComponentFixture<CreateRasadnikComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ CreateRasadnikComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CreateRasadnikComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
