import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MapModalSupermercadoComponent } from './map-modal-supermercado.component';

describe('MapModalSupermercadoComponent', () => {
  let component: MapModalSupermercadoComponent;
  let fixture: ComponentFixture<MapModalSupermercadoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MapModalSupermercadoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MapModalSupermercadoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
