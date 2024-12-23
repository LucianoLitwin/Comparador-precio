import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AppMessageModalComponent } from './app-message-modal.component';

describe('AppMessageModalComponent', () => {
  let component: AppMessageModalComponent;
  let fixture: ComponentFixture<AppMessageModalComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AppMessageModalComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AppMessageModalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
