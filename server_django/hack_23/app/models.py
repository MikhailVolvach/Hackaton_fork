from django.db import models

# Create your models here.
# class Map(models.Model):
#     image = models.CharField(max_length=100)

class MapElenent(models.Model):
    arr_data = models.JSONField(blank=True, null=True)
    x_max = models.IntegerField(default=300)
    x_min = models.IntegerField(default=150)

    y_max = models.IntegerField(default=250)
    y_min = models.IntegerField(default=100)
    # map = models.ForeignKey('Map', on_delete=models.CASCADE)
    # x = models.IntegerField()
    # y = models.IntegerField()
    # height = models.IntegerField()


# class CurrentValues(models.Model):
#     x_max = models.IntegerField(default=300)
#     y_max = models.IntegerField(default=300)
#     x_min = models.IntegerField(default=100)
#     y_min = models.IntegerField(default=100)
#     position = models.ForeignKey('MapElenent', on_delete=models.CASCADE)

