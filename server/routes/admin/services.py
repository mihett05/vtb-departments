import random

from schemes import Statistics

from datetime import datetime, timedelta


async def create_initial_stats_office() -> list[Statistics]:
    stats = []
    start_date = datetime.now() - timedelta(days=7)
    start_date.replace(hour=0)

    for day in range(7):
        for hour in range(3):
            cur_date = start_date + timedelta(days=day, hours=hour)
            statistic = Statistics(time_series=cur_date, load=random.random())
            await statistic.create()
            stats.append(statistic)

    return stats
