import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { MagPorudzbineComponent } from './mag-porudzbine.component';

describe('MagPorudzbineComponent', () => {
  let component: MagPorudzbineComponent;
  let fixture: ComponentFixture<MagPorudzbineComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ MagPorudzbineComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MagPorudzbineComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
