import { TestBed } from '@angular/core/testing';

import { AutorizacijPoljService } from './autorizacij-polj.service';

describe('AutorizacijPoljService', () => {
  let service: AutorizacijPoljService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AutorizacijPoljService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
