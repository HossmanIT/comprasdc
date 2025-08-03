from sqlalchemy import Column, String, DateTime, Float, Boolean
from core.database import Base

class SQLCOMPC01(Base):
    __tablename__ = "SQLCOMPC01"
    
    CVE_DOC = Column(String, primary_key=True)
    NOMBRE = Column(String)
    SU_REFER = Column(String)
    FECHA_DOC = Column(DateTime)
    MONEDA = Column(String)
    TIPCAMB = Column(Float)
    TOT_IND = Column(Float)
    IMPORTE = Column(Float)
    IMPORTEME = Column(Float)
    SINCRONIZADO = Column(Boolean, default=False, nullable=False)