import { TestBed } from '@angular/core/testing';

import { MapeService } from './mape.service';

describe('MapeService', () => {
  let service: MapeService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MapeService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
