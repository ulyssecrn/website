// Swap each .kicanvas placeholder for a <kicanvas-embed> on first tap.
document.addEventListener("click", async (e) => {
  const btn = e.target.closest(".kicanvas-load");
  if (!btn) return;
  const box = btn.closest(".kicanvas");
  btn.disabled = true;
  btn.textContent = "Loading…";
  await import("/vendor/kicanvas.js");
  const embed = document.createElement("kicanvas-embed");
  embed.setAttribute("src", box.dataset.src);
  // "full" adds the side panel: layer visibility, objects and properties.
  embed.setAttribute("controls", "full");
  box.replaceChildren(embed);
  box.classList.add("loaded");
});
