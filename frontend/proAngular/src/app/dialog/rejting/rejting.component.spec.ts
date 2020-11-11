import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RejtingComponent } from './rejting.component';

describe('RejtingComponent', () => {
  let component: RejtingComponent;
  let fixture: ComponentFixture<RejtingComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RejtingComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RejtingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
