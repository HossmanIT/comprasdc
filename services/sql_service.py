from datetime import datetime, date
from typing import List
from sqlalchemy.orm import Session
from models.entities import SQLCOMPC01
import logging

logger = logging.getLogger(__name__)

class SQLService:
    def __init__(self, db: Session):
        self.db = db
    
    def get_today_purchases(self) -> List[SQLCOMPC01]:
        """Obtiene las facturas del día actual"""
        today = date.today()
        start_date = datetime.combine(today, datetime.min.time())
        end_date = datetime.combine(today, datetime.max.time())
        
        try:
            purchases = self.db.query(SQLCOMPC01).filter(
            SQLCOMPC01.FECHA_DOC >= start_date,
            SQLCOMPC01.FECHA_DOC <= end_date,
            SQLCOMPC01.SINCRONIZADO == False
            ).all()
            
            logger.info(f"Encontradas {len(purchases)} facturas para hoy")
            return purchases
        except Exception as e:
            logger.error(f"Error al obtener facturas: {str(e)}")
            raise