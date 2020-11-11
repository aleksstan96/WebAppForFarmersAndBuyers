import { TestBed } from '@angular/core/testing';

import { PorudzbiniService } from './porudzbini.service';

describe('PorudzbiniService', () => {
  let service: PorudzbiniService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PorudzbiniService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
