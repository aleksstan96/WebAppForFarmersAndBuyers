import { TestBed } from '@angular/core/testing';

import { AutorizacijaPreduzeceService } from './autorizacija-preduzece.service';

describe('AutorizacijaPreduzeceService', () => {
  let service: AutorizacijaPreduzeceService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AutorizacijaPreduzeceService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
