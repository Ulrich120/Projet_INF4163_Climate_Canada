import Canada from "@svg-maps/canada";

const NAME_TO_CODE = {
  Alberta: "AB",
  "British Columbia": "BC",
  Manitoba: "MB",
  "New Brunswick": "NB",
  "Newfoundland and Labrador": "NL",
  "Northwest Territories": "NT",
  "Nova Scotia": "NS",
  Nunavut: "NU",
  Ontario: "ON",
  "Prince Edward Island": "PE",
  Quebec: "QC",
  Saskatchewan: "SK",
  Yukon: "YT",
};

function CanadaMap({ selectedProvince, onProvinceChange }) {
  return (
    <div className="canada-map-wrapper">
      <svg
        viewBox={Canada.viewBox}
        className="canada-map"
        role="img"
        aria-label="Carte interactive du Canada"
      >
        {Canada.locations.map((location) => {
          const code = NAME_TO_CODE[location.name];
          const isSelected = code === selectedProvince;

          return (
            <path
              key={location.id}
              id={location.id}
              name={location.name}
              d={location.path}
              className={
                isSelected ? "canada-location canada-location-selected" : "canada-location"
              }
              onClick={() => {
                if (code) onProvinceChange(code);
              }}
            >
              <title>{location.name}</title>
            </path>
          );
        })}
      </svg>

      <div className="map-selected-label">
        <span>Province sélectionnée</span>
        <strong>{selectedProvince}</strong>
      </div>
    </div>
  );
}

export default CanadaMap;
