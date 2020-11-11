import { TestBed } from '@angular/core/testing';

import { KuririService } from './kuriri.service';

describe('KuririService', () => {
  let service: KuririService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(KuririService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
