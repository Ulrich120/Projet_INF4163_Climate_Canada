import pytest
from analyze_ges import (
    BASE_YEAR,
    ELECTRICITY,
    LAST_YEAR,
    NATIONAL_TOTAL,
    decline_breakdown,
    read_national_sectors,
    reconcile,
)


@pytest.fixture(scope="module")
def sectors():
    return read_national_sectors()


def test_national_total_matches_sum_of_provinces(sectors):
    # seul l'arrondi à 0,01 Mt par province sépare les deux sources
    assert reconcile(sectors[NATIONAL_TOTAL]).abs().max() < 0.05


def test_sectors_add_up_to_national_total(sectors):
    parts = sectors.drop(columns=[NATIONAL_TOTAL])
    assert (parts.sum(axis=1) - sectors[NATIONAL_TOTAL]).abs().max() < 0.05


def test_decline_breakdown_adds_up_and_electricity_leads(sectors):
    breakdown = decline_breakdown(sectors)
    total_change = sectors.loc[LAST_YEAR, NATIONAL_TOTAL] - sectors.loc[BASE_YEAR, NATIONAL_TOTAL]
    assert breakdown["variation_Mt"].sum() == pytest.approx(total_change, abs=0.05)
    assert breakdown.index[0] == ELECTRICITY
