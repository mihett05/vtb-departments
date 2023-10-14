from beanie import Link

from schemes import Statistics


async def create_initial_stats_office() -> list[Statistics]:
    statistic = Statistics(meta=0.5)
    await statistic.create()
    return [statistic]
