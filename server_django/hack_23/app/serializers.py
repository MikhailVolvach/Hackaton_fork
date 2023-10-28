from rest_framework import serializers
from app.models import MapElenent

class MapElementSerializer(serializers.ModelSerializer):
    class Meta:
        model = MapElenent
        fields = [
            
        ]
