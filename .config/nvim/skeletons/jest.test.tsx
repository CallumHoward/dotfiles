import React from "react";
import { initRender, screen } from "@safetyculture/testing-library";

const { render } = initRender();

describe("description", () => {
  const componentDA = "component-da";

  it("description", () => {
    render(<Component />);
    expect(screen.queryByDataAnchor(componentDA)).toBeInTheDocument();
  });
});
