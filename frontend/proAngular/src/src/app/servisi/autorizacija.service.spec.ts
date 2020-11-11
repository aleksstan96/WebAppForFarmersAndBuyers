import { TestBed } from '@angular/core/testing';

import { AutorizacijaService } from './autorizacija.service';

describe('AutorizacijaService', () => {
  let service: AutorizacijaService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AutorizacijaService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
