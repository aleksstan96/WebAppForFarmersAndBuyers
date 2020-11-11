import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { IzmenaAdminaComponent } from './izmena-admina.component';

describe('IzmenaAdminaComponent', () => {
  let component: IzmenaAdminaComponent;
  let fixture: ComponentFixture<IzmenaAdminaComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ IzmenaAdminaComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IzmenaAdminaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
